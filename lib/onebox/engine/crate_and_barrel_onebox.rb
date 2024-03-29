module Onebox
  module Engine
    class CrateAndBarrelOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.crateandbarrel\.com\//)

      def price
        og_raw.metadata[:'price:amount'].first
      end

      def price_cents
        Monetize.parse(price).cents.to_s
      end

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
          price: price,
          price_cents: price_cents
        }
      end
    end
  end
end
