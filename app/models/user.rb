class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_one_attached :avatar
    def self.from_token_payload(payload)
        # find_by(sub: payload['sub']) || create!(sub: payload['sub'])
        if user = find_by(sub: payload['sub'])
            user
        else
            uid = SecureRandom.uuid
            payload_sub = payload['sub']
            picture = payload['picture']
            name = payload['name']
            user = create!(sub: payload_sub, uid: uid, name: name)
            #twitterの場合、画像URLから_normalを削除して保存（大きいサイズの画像を取得するため）
            if payload_sub.include?('twitter')
                pictureUrl = picture.gsub(/_normal/, '')
            end
            if pictureUrl
                image = URI.open(pictureUrl)
                user.avatar.attach(
                    io: image,
                    filename: File.basename(URI.parse(picture).path),
                    content_type: image.content_type
                )
    
                image_url = user.avatar.attachment.service.send(:object_for, user.avatar.key).public_url #S3から画像URLを取得
                user.assign_attributes(image_url: image_url)
                if user.save
                    user
                end
            else
                create!(sub: payload_sub, uid: uid, name: name)
            end
        end
    end


    # def self.from_token_payload payload
    #     uid = SecureRandom.uuid
    #     payload_sub = payload['sub']
    #     picture = payload['picture']
    #     name = payload['name']
    #     find_by(sub: payload['sub']) || create!(sub: payload_sub, uid: uid, name: name)
    # end

end
