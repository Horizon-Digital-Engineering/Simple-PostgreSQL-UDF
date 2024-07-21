
MODULES = string_udf
EXTENSION = string_udf
DATA = string_udf--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
