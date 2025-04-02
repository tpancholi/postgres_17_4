-- Enable citext extension for case-insensitive text matching
CREATE EXTENSION IF NOT EXISTS citext;

-- Enable pg_trgm extension for trigram-based similarity searching
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Enable uuid-ossp extension for generating UUIDs using various algorithms (v1, v3, v4)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enable hstore extension for storing key-value pairs in a single column
CREATE EXTENSION IF NOT EXISTS hstore;

-- Enable UUID v7 extension - try different extension names depending on which method you used
CREATE EXTENSION IF NOT EXISTS pg_uuidv7;
-- If the above fails, try this alternative
-- CREATE EXTENSION IF NOT EXISTS uuid_v7;

-- Creating non-root user and granting privileges to user
CREATE ROLE myapp_user WITH LOGIN PASSWORD 'pa55word';
GRANT ALL PRIVILEGES ON DATABASE datamover TO myapp_user;

-- Example table using uuidv7 as primary key
-- Try different function names depending on which extension you're using
CREATE TABLE example_table (
    -- For fboulnois/pg_uuidv7
    id UUID PRIMARY KEY DEFAULT uuid_generate_v7(),
    -- Alternatively for other implementations, try:
    -- id UUID PRIMARY KEY DEFAULT uuid_generate_v7(),
    -- Or:
    -- id UUID PRIMARY KEY DEFAULT uuid_v7(),
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Grant privileges on the example table to myapp_user
GRANT ALL PRIVILEGES ON TABLE example_table TO myapp_user;

-- Insert example data using uuidv7
INSERT INTO example_table (name) VALUES ('Example Record 1');
INSERT INTO example_table (name) VALUES ('Example Record 2');

-- Query to verify data (you can run this after initialization)
-- SELECT * FROM example_table;
