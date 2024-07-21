
CREATE FUNCTION string_udf(input text) RETURNS text
AS 'string_udf', 'string_udf'
LANGUAGE C STRICT;
