class MigrateDeprecatedKindsTeams < ActiveRecord::Migration[5.1]
  def up
    migrate_sponsored_teams_to_full_time
    migrate_voluntary_teams_to_part_time
  end

  def down
    migrate_full_time_teams_to_sponsored
    migrate_part_time_teams_to_voluntary
  end

  private

  def migrate_sponsored_teams_to_full_time
    execute <<-SQL
      UPDATE teams
      SET kind = 'full_time'
      WHERE kind = 'sponsored'
    SQL
  end

  def migrate_voluntary_teams_to_part_time
    execute <<-SQL
      UPDATE teams
      SET kind = 'part_time'
      WHERE kind = 'voluntary'
    SQL
  end

  def migrate_full_time_teams_to_sponsored
    execute <<-SQL
      UPDATE teams
      SET kind = 'sponsored'
      WHERE kind = 'full_time'
    SQL
  end

  def migrate_part_time_teams_to_voluntary
    execute <<-SQL
      UPDATE teams
      SET kind = 'voluntary'
      WHERE kind = 'part_time'
    SQL
  end
end
