#encoding = utf-8
ActiveAdmin::Dashboards.build do
  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #

  section "Новости за последние 24 часа", :priority => 1 do
    table_for Post.where("published_at >= ?", 1.day.ago).order('id desc') do
      column("Заголовок") { |post| link_to(post.title, admin_post_path(post), :title => strip_tags(post.body).gsub(/\s+/, ' ').strip) }
      column("Категория") { |post| post.categories.first.to_s }
      column("Дата") { |post| post.created_at.to_s }
    end
  end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
