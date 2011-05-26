module Features::Commentable
  def self.included(model)
    model.class_eval do
      attr_readonly :comments_count

      has_many :comments, :as => :target
    end
  end

  def add_comment(user, content, options = {})
    options = { :is_private => false }.merge(options)

    Comment.create(
      :content     => content,
      :is_private  => options[:is_private],
      :target_id   => id,
      :target_type => self.class.name,
      :user_id     => user.id
    ) && reload
  end

  def add_private_comment(user, content, options = {})
    options.merge!({ :is_private => true })

    add_comment(user, content, options)
  end
end