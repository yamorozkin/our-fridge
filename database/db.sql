CREATE TABLE IF NOT EXISTS categories(
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS products(
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL UNIQUE,
    product_count DECIMAL(8,2),
    category_id INTEGER NOT NULL REFERENCES categories(category_id),
    UNIQUE(product_name, category_id)
);

CREATE TABLE IF NOT EXISTS dishes(
    dish_id SERIAL PRIMARY KEY,
    dish_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    dish_time DECIMAL(8,2)
);


CREATE TABLE IF NOT EXISTS dish_ingredients(
    dish_ingredient_id SERIAL PRIMARY KEY,
    dish_id INTEGER NOT NULL REFERENCES dishes(dish_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    dish_ingredient_count DECIMAL(8,2),
    UNIQUE(dish_id, product_id)
);