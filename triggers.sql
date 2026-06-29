--automatically marks a borrow as overdue
CREATE OR REPLACE FUNCTION trg_set_overdue()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.due_date < CURRENT_DATE AND NEW.return_date IS NULL THEN
        NEW.status := 'Overdue';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_borrow_insert
BEFORE INSERT OR UPDATE ON borrow_records
FOR EACH ROW
EXECUTE FUNCTION trg_set_overdue();

--this second trigger is used for audit logging 
CREATE OR REPLACE FUNCTION log_member_changes()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN

    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log(table_name, operation, changed_by, new_data)
        VALUES (
            'members',
            TG_OP,
            CURRENT_USER,
            to_jsonb(NEW)
        );
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log(table_name, operation, changed_by, old_data, new_data)
        VALUES (
            'members',
            TG_OP,
            CURRENT_USER,
            to_jsonb(OLD),
            to_jsonb(NEW)
        );
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit_log(table_name, operation, changed_by, old_data)
        VALUES (
            'members',
            TG_OP,
            CURRENT_USER,
            to_jsonb(OLD)
        );
        RETURN OLD;

    END IF;

END;
$$;

CREATE TRIGGER member_audit_trigger
AFTER INSERT OR UPDATE OR DELETE
ON members
FOR EACH ROW
EXECUTE FUNCTION log_member_changes();