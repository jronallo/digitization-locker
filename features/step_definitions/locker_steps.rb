Given /^a locker$/ do
  File.exists?(APP_CONFIG[:locker]).should be_true
end

When /^I move the file "([^"]*)" to the locker$/ do |arg1|
  expect {
    FileUtils.cp(Rails.root.join('spec/images', arg1),
      File.join(APP_CONFIG[:locker], '.') )
   }.to_not raise_error
end

Then /^I should see "([^"]*)" within the locker$/ do |arg1|
  File.exists?( File.join(APP_CONFIG[:locker], arg1 )).should be_true
end

When /^the locker processing script has run enough times to make it stable$/ do
  (APP_CONFIG[:stable_interval] + 1).times do
    require 'rake'
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'lib/tasks/locker'
    Rake::Task.define_task(:environment)
    @rake['locker:watch'].invoke
  end
end

Then /^I should see "([^"]*)" in the holding tank$/ do |arg1|
  File.exists?( File.join(APP_CONFIG[:tank], arg1 )).should be_true
end
