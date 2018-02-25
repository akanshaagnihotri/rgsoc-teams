class MigrateDeprecatedKindsTeams < ActiveRecord::Migration[5.1]
  class Team < ApplicationRecord
    self.table_name = 'teams'
  end

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
    Team.where(kind: 'sponsored').update_all(kind: 'full_time')
  end

  def migrate_voluntary_teams_to_part_time
    Team.where(kind: 'voluntary').update_all(kind: 'part_time')
  end

  def migrate_full_time_teams_to_sponsored
    Team.where(kind: 'full_time').update_all(kind: 'sponsored')
  end

  def migrate_part_time_teams_to_voluntary
    Team.where(kind: 'part_time').update_all(kind: 'voluntary')
  end
end
