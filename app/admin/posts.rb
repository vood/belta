#encoding: utf-8
ActiveAdmin.register Post do
  menu :label => "Новости"

  index do

    column :title, :sortable => :title  do |post|
      link_to post.title, edit_admin_post_path(post), :title => strip_tags(post.body).strip
    end

    column :published_at
    column :created_at
    column :updated_at


    column :categories do |post|
      link_to post.categories.first, admin_category_path(post.categories.first)
    end

    default_actions
  end

  form do |f|
    f.inputs do
      f.input :categories
      f.input :source
      f.input :is_ad
      f.input :related
      f.input :rating, :as => :select, :collection => { 'Позитивная' => 1, 'Нейтральная' => 0, 'Негативная' => -1 }
      f.input :theme
      f.input :title
      f.input :body, :input_html => { :class => 'editor' }
      f.input :published_at
    end
    f.buttons
  end

end
