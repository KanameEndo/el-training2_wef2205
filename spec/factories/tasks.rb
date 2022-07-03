FactoryBot.define do

  factory :task do
    name { 'name1' }
    content { 'content1' }
    deadline { DateTime.now }
    status {'完了'}
    priority {'高'}
  end

  factory :second_task, class: Task do
    name { 'name2' }
    content { 'content2' }
    deadline { DateTime.now +5 }
    status {'進行中'}
    priority {'中'}
  end

  factory :third_task, class: Task do
    name { 'name3' }
    content { 'content3' }
    deadline { DateTime.now +5 }
    status {'未着手'}
    priority {'低'}
  end
end