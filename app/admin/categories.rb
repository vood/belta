ActiveAdmin.register Category do
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :tag_list
    end
    f.buttons
  end
end
