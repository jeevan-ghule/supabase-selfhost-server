CREATE EXTENSION pg_cron;

SELECT cron.schedule('nightly-vacuum', '0 10 * * *', 'VACUUM');
