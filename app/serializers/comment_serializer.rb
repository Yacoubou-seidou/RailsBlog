class CommentSerializer < ActiveModel::Serializer
  attributes :username, :text

  def username
    object.user.name
  end
end
