

/*******************************************************************************
    Create xample data
*******************************************************************************/

-- CREATE 'cust_status' table
DROP TABLE IF EXISTS
    cust_status
;
CREATE TABLE
    cust_status
    (
        customer_id INTEGER NOT NULL
    ,   date        DATE    NOT NULL
    ,   status      VARCHAR NOT NULL
    ,   PRIMARY KEY
        (
            customer_id
        ,   date
        )
    )
;


-- INSERT INTO 'cust_status' table
INSERT INTO
    cust_status
    (
        customer_id
    ,   date
    ,   status
    )
VALUES
    (
        1701
    ,   '2020-02-24'
    ,   'warned'
    )
;


/*******************************************************************************
    Upsert
*******************************************************************************/

-- the following causes NO CHANGE
INSERT INTO
    cust_status
    (
        customer_id
    ,   date
    ,   status
    )
VALUES
    (
        1701
    ,   '2020-02-24'
    ,   'blocked'
    )
ON CONFLICT ON CONSTRAINT
    cust_status_pkey
DO NOTHING
;


-- the following causes UPDATE
INSERT INTO
    cust_status
    (
        customer_id
    ,   date
    ,   status
    )
VALUES
    (
        1701
    ,   '2020-02-24'
    ,   'blocked'
    )
ON CONFLICT ON CONSTRAINT
    cust_status_pkey
DO UPDATE
    SET status = cust_status.status || ',' || EXCLUDED.status
;