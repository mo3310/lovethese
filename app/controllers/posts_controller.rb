class PostsController < ApplicationController
  def new
  end

  def create
    # 投稿とタグに関する記述
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(nil)
    if @post.save
      @post.save_tag(tag_list)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @tag_list = Tag.all              #ビューでタグ一覧を表示するために全取得
    @posts = Post.all                #ビューで投稿一覧を表示するために全取得
    @post = current_user.posts.new   #ビューのform_withのmodelに使う
  end

  def show
    @post = Post.find(params[:id])  #クリックした投稿を取得。
    @post_tags = @post.tags         #そのクリックした投稿に紐付けられているタグの取得
  end

  def destroy
  end

  private
  def post_params
  params.require(:post).permit(:content)
  end

end
