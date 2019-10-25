module Concerns

    module Findable

        def find_by_name(name)
            all.detect{|x| x.name==name}
        end

        def find_or_create_by_name(name)
            if find_by_name(name)
                song= find_by_name(name)
            else
                song= create(name)
            end
            song
        end

    end

end