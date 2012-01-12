#encoding = utf-8
ActiveAdmin.register Category do
  menu :label => "Категории"
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :tag_list
    end
    f.buttons
  end
end
