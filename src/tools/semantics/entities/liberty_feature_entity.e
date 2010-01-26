-- This file is part of Liberty Eiffel.
--
-- Liberty Eiffel is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, version 3 of the License.
--
-- Liberty Eiffel is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Liberty Eiffel.  If not, see <http://www.gnu.org/licenses/>.
--
class LIBERTY_FEATURE_ENTITY
--
-- A proxy to the feature itself.
--
-- See also LIBERTY_WRITABLE_FEATURE
--

inherit
	LIBERTY_ENTITY

create {LIBERTY_TYPE_BUILDER_TOOLS}
	make

feature {ANY}
	name: FIXED_STRING is
		do
			Result := feature_name.name
		end

	out_in_tagged_out_memory is
		do
			tagged_out_memory.append(once "feature: ")
			feature_name.out_in_tagged_out_memory
		end

	feature_name: LIBERTY_FEATURE_NAME

	result_type: LIBERTY_TYPE is
		do
			if the_feature /= Void then
				Result := the_feature.result_type
			else
				not_yet_implemented
			end
		end

feature {LIBERTY_TYPE_BUILDER_TOOLS}
	set_feature (a_feature: like the_feature) is
		do
			the_feature := a_feature
		ensure
			the_feature = a_feature
		end

feature {}
	the_feature: LIBERTY_FEATURE

	make (a_name: like feature_name) is
		require
			a_name /= Void
		do
			feature_name := a_name
			position := a_name.position
		ensure
			feature_name = a_name
			position = a_name.position
		end

end
