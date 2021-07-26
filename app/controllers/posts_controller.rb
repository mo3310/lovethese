class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
    # # 投稿とタグに関する記述 書き換え検討中
    # @post = current_user.posts.new(post_params)
    # # tag_list = params[:post][:tag_name].split(nil)
    # if @post.save
    #   @post.save_tag(tag_list)
    #   redirect_back(fallback_location: root_path)
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
    @tag_list = Tag.all              #ビューでタグ一覧を表示するために全取得
    @post = current_user.posts.new   #ビューのform_withのmodelに使う
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post.tags         #投稿に紐付けられているタグの取得
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

def search
    @tag_list = Tag.all  #こちらの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

end
