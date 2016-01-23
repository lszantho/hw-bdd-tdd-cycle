FactoryGirl.define do
    factory :movie do
        title "Some title"
        rating "PG"
        release_date 10.years.ago
    end
end