#include <postgres.h>
#include <fmgr.h>
#include <utils/builtins.h>

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(string_udf);

Datum
string_udf(PG_FUNCTION_ARGS)
{
    text *input = PG_GETARG_TEXT_PP(0);
    text *result = (text *) palloc(VARSIZE(input));
    SET_VARSIZE(result, VARSIZE(input));
    memcpy(VARDATA(result), VARDATA(input), VARSIZE(input) - VARHDRSZ);

    PG_RETURN_TEXT_P(result);
}
