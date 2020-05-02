defmodule Lychee.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIEW ingredients AS
    SELECT s.meal_id,
       s.item_id,
       s.weight,
       i.name,
       cast(s.weight * i.kcal / 100 AS numeric(10, 1))     AS kcal,
       cast(s.weight * i.carbs / 100 AS numeric(10, 1))    AS carbs,
       cast(s.weight * i.proteins / 100 AS numeric(10, 1)) AS proteins,
       cast(s.weight * i.fat / 100 AS numeric(10, 1))      AS fat
    FROM meals_items s
    INNER JOIN items i ON (s.item_id = i.id);
    """

    execute """
    CREATE OR REPLACE FUNCTION insert_ingredient() RETURNS trigger AS
    $$
    DECLARE
    BEGIN
      INSERT INTO meals_items (meal_id, item_id, weight, inserted_at, updated_at)
      SELECT NEW.meal_id, NEW.item_id, NEW.weight, now(), now();
      RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    """

    execute """
    CREATE TRIGGER insert_ingredient_trg
    INSTEAD OF INSERT
    ON ingredients
    FOR EACH ROW
    EXECUTE FUNCTION insert_ingredient();
    """

    execute """
    CREATE OR REPLACE FUNCTION delete_ingredient() RETURNS trigger AS
    $$
    DECLARE
    BEGIN
      DELETE FROM meals_items WHERE meal_id = OLD.meal_id AND item_id = OLD.item_id;
      RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;
    """

    execute """
    CREATE TRIGGER delete_ingredient_trg
    INSTEAD OF DELETE
    ON ingredients
    FOR EACH ROW
    EXECUTE FUNCTION delete_ingredient();
    """
  end

  def down do
    execute "DROP VIEW ingredients;"
    execute "DROP FUNCTION insert_ingredient;"
    execute "DROP FUNCTION delete_ingredient;"
  end
end
