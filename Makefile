MODULES = string_udf
EXTENSION = string_udf
DATA = string_udf--1.0.sql
CONTROL = string_udf.control

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
