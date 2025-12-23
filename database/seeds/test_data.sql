-- 1. КАТЕГОРИИ (минимум)
INSERT INTO categories (category_name) VALUES
('Овощи'),
('Молочные продукты'),
('Мясо'),
('Бакалея')
ON CONFLICT (category_name) DO NOTHING;

-- 2. ПРОДУКТЫ (базовый набор)
INSERT INTO products (product_name, product_count, category_id) VALUES
-- Овощи
('Картофель', 2.5, (SELECT category_id FROM categories WHERE category_name = 'Овощи')),
('Морковь', 1.0, (SELECT category_id FROM categories WHERE category_name = 'Овощи')),
('Лук', 0.5, (SELECT category_id FROM categories WHERE category_name = 'Овощи')),

-- Молочные продукты
('Молоко', 1.0, (SELECT category_id FROM categories WHERE category_name = 'Молочные продукты')),
('Яйца', 0.6, (SELECT category_id FROM categories WHERE category_name = 'Молочные продукты')),
('Сыр', 0.3, (SELECT category_id FROM categories WHERE category_name = 'Молочные продукты')),

-- Мясо
('Курица', 0.8, (SELECT category_id FROM categories WHERE category_name = 'Мясо')),

-- Бакалея
('Рис', 1.0, (SELECT category_id FROM categories WHERE category_name = 'Бакалея'))
ON CONFLICT (product_name, category_id) DO NOTHING;

-- 3. БЛЮДА (3 простых рецепта)
INSERT INTO dishes (dish_name, description, dish_time) VALUES
('Омлет', 'Простой омлет с зеленью', 10.0),
('Куриный суп', 'Лёгкий суп с курицей и овощами', 40.0),
('Жареная картошка', 'Картофель с луком', 25.0)
ON CONFLICT (dish_name) DO NOTHING;

-- 4. ИНГРЕДИЕНТЫ ДЛЯ БЛЮД
INSERT INTO dish_ingredients (dish_id, product_id, dish_ingredient_count) VALUES
-- Омлет
((SELECT dish_id FROM dishes WHERE dish_name = 'Омлет'),
 (SELECT product_id FROM products WHERE product_name = 'Яйца'), 0.3), -- 3 яйца

-- Куриный суп
((SELECT dish_id FROM dishes WHERE dish_name = 'Куриный суп'),
 (SELECT product_id FROM products WHERE product_name = 'Курица'), 0.4),
((SELECT dish_id FROM dishes WHERE dish_name = 'Куриный суп'),
 (SELECT product_id FROM products WHERE product_name = 'Картофель'), 0.3),
((SELECT dish_id FROM dishes WHERE dish_name = 'Куриный суп'),
 (SELECT product_id FROM products WHERE product_name = 'Морковь'), 0.2),
((SELECT dish_id FROM dishes WHERE dish_name = 'Куриный суп'),
 (SELECT product_id FROM products WHERE product_name = 'Лук'), 0.1),

-- Жареная картошка
((SELECT dish_id FROM dishes WHERE dish_name = 'Жареная картошка'),
 (SELECT product_id FROM products WHERE product_name = 'Картофель'), 0.5),
((SELECT dish_id FROM dishes WHERE dish_name = 'Жареная картошка'),
 (SELECT product_id FROM products WHERE product_name = 'Лук'), 0.2)
ON CONFLICT (dish_id, product_id) DO NOTHING;

