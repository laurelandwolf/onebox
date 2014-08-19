module Onebox
  module Engine
    class TargetOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/(www.|http:\/\/(www.)?|https:\/\/(www.)?)?target\.com\/p\//)

      def data
        if og_raw.is_a?(Hash)
          og_raw[:link] ||= link
          return og_raw
        end

        {
          link: link,
          title: og_raw.title,
          image: (og_raw.images.first if og_raw.images && og_raw.images.first),
          description: og_raw.description,
          type: (og_raw.type if og_raw.type),
          price_cents: Monetize.parse(raw.css('#price_main > div > p > span.offerPrice')).cents.to_s
        }
      end
    end
  end
end