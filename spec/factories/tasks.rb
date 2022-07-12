FactoryBot.define do

  factory :task do
    name { 'task' }
    content { 'task' }
    deadline { DateTime.now }
    status {'完了'}
    priority {'高'}
  end

  factory :second_task, class: Task do
    name { 'task2' }
    content { 'task2' }
    deadline { DateTime.now +5 }
    status {'進行中'}
    priority {'中'}
  end

  factory :third_task, class: Task do
    name { 'task3' }
    content { 'task3' }
    deadline { DateTime.now +5 }
    status {'未着手'}
    priority {'低'}
  end
end