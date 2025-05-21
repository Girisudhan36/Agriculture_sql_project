CREATE TABLE crop_data (
    id SERIAL ,
    state_name TEXT,
    crop_type TEXT,
    crop TEXT,
    nitrogen INTEGER,
    phosphorus INTEGER,
    potassium INTEGER,
    ph NUMERIC(4, 2),
    rainfall NUMERIC(6, 2),
    temperature NUMERIC(5, 2),
    area_in_hectares NUMERIC(10, 2),       
    production_in_tons NUMERIC(10, 2),    
    yield_ton_per_hec NUMERIC(10, 4)        
);
