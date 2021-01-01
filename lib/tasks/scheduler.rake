desc "Delete games not used in a week"
task :clear_old_games => :environment do
  puts "Clearing old games..."
  Game.where(['updated_at < ?', 1.week.ago]).destroy_all
  puts "done."
end
