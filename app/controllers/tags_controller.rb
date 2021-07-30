class TagsController < ApplicationController
  def create
    @post = current_user.posts.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tags].split(nil)    # タグに関する記述
    if @post.save
      @post.save_tag(tag_list)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
