
/******************************************************************************/
/* SQL Pass-Through Facility
/******************************************************************************/

proc sql
    noerrorstop
;

/*- connect ------------------------------------------------------------------*/
    connect to
        postgres
    as
        psql
        (   server   = localhost
            port     = 5432
            user     = postgres
            password = 'passw'
            database = postgres
        )
    ;

	/* Create database 'db_test'
	*/
    execute
    (   CREATE DATABASE
            db_test
    )
    by psql;

    disconnect from psql;
/*- disconnect ---------------------------------------------------------------*/


/*- connect ------------------------------------------------------------------*/
    connect to
        postgres
    as
        psql
        (   server   = localhost
            port     = 5432
            user     = postgres
            password = 'passw'
            database = db_test
        )
    ;


    execute
    (
        /* Create table 'tbl_test'
        */
        DROP TABLE IF EXISTS
            tbl_test
        ;

        CREATE TABLE
            tbl_test
            (
                id   BIGSERIAL NOT NULL PRIMARY KEY,
                name VARCHAR(50)
            )
        ;

        /* Insert rows into table 'tbl_test'
        */
        INSERT INTO
            tbl_test
                ( id, name   )
            VALUES
                ( 10, 'Nico' ),
                ( 20, 'Mo'   )
        ;
    )
    by psql;

    disconnect from psql;
/*- disconnect ---------------------------------------------------------------*/

quit;




proc sql
    noerrorstop
;

/*- connect ------------------------------------------------------------------*/
    connect to
        postgres
    as
        psql
        (   server   = localhost
            port     = 5432
            user     = postgres
            password = 'passw'
            database = db_test
        )
    ;

	/* Fetch data from table 'tbl_test'
	*/
    select
        *
    from
        connection to psql
        (   SELECT
                *
            FROM
                tbl_test
        )
    ;

/*- disconnect ---------------------------------------------------------------*/
    disconnect from psql;
quit;



/******************************************************************************/
/* LIBNAME Statement
/******************************************************************************/

libname psql
    postgres
    server   = localhost
    database = db_test
    port     = 5432
    user     = postgres
    password = 'passw'
;

libname psql
    clear
;

