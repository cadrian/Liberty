-- See the Copyright notice at the end of this file.
--
expanded class UNICODE_CHARACTERS
--
-- Unicode character classes helper features
--

feature {ANY}
   is_separator (unicode: INTEGER): BOOLEAN
      do
         inspect
            unicode
         when 9, 10, 13, 32 then
            -- standard ASCII separators
            Result := True
         when 0x000000A0, 0x00001680, 0x0000180E, 0x00002000..0x0000200A, 0x0000200F, 0x0000205F, 0x00003000 then
            -- extended Unicode 'Separator, Space' category
            -- (see http://www.fileformat.info/info/unicode/category/Zs/list.htm)
            Result := True
         else
            check not Result end
         end
      end

   is_base_char (unicode: INTEGER): BOOLEAN
      do
         inspect
            unicode
         when 0x00000041..0x0000005A, 0x00000061..0x0000007A, 0x000000C0..0x000000D6, 0x000000D8..0x000000F6, 0x000000F8..0x000000FF, 0x00000100..0x00000131, 0x00000134..0x0000013E, 0x00000141..0x00000148, 0x0000014A..0x0000017E, 0x00000180..0x000001C3, 0x000001CD..0x000001F0, 0x000001F4..0x000001F5, 0x000001FA..0x00000217, 0x00000250..0x000002A8, 0x000002BB..0x000002C1, 0x00000386, 0x00000388..0x0000038A, 0x0000038C, 0x0000038E..0x000003A1, 0x000003A3..0x000003CE, 0x000003D0..0x000003D6, 0x000003DA, 0x000003DC, 0x000003DE, 0x000003E0, 0x000003E2..0x000003F3, 0x00000401..0x0000040C, 0x0000040E..0x0000044F, 0x00000451..0x0000045C, 0x0000045E..0x00000481, 0x00000490..0x000004C4, 0x000004C7..0x000004C8, 0x000004CB..0x000004CC, 0x000004D0..0x000004EB, 0x000004EE..0x000004F5, 0x000004F8..0x000004F9, 0x00000531..0x00000556, 0x00000559, 0x00000561..0x00000586, 0x000005D0..0x000005EA, 0x000005F0..0x000005F2, 0x00000621..0x0000063A, 0x00000641..0x0000064A, 0x00000671..0x000006B7, 0x000006BA..0x000006BE, 0x000006C0..0x000006CE, 0x000006D0..0x000006D3, 0x000006D5, 0x000006E5..0x000006E6, 0x00000905..0x00000939, 0x0000093D, 0x00000958..0x00000961, 0x00000985..0x0000098C, 0x0000098F..0x00000990, 0x00000993..0x000009A8, 0x000009AA..0x000009B0, 0x000009B2, 0x000009B6..0x000009B9, 0x000009DC..0x000009DD, 0x000009DF..0x000009E1, 0x000009F0..0x000009F1, 0x00000A05..0x00000A0A, 0x00000A0F..0x00000A10, 0x00000A13..0x00000A28, 0x00000A2A..0x00000A30, 0x00000A32..0x00000A33, 0x00000A35..0x00000A36, 0x00000A38..0x00000A39, 0x00000A59..0x00000A5C, 0x00000A5E, 0x00000A72..0x00000A74, 0x00000A85..0x00000A8B, 0x00000A8D, 0x00000A8F..0x00000A91, 0x00000A93..0x00000AA8, 0x00000AAA..0x00000AB0, 0x00000AB2..0x00000AB3, 0x00000AB5..0x00000AB9, 0x00000ABD, 0x00000AE0, 0x00000B05..0x00000B0C, 0x00000B0F..0x00000B10, 0x00000B13..0x00000B28, 0x00000B2A..0x00000B30, 0x00000B32..0x00000B33, 0x00000B36..0x00000B39, 0x00000B3D, 0x00000B5C..0x00000B5D, 0x00000B5F..0x00000B61, 0x00000B85..0x00000B8A, 0x00000B8E..0x00000B90, 0x00000B92..0x00000B95, 0x00000B99..0x00000B9A, 0x00000B9C, 0x00000B9E..0x00000B9F, 0x00000BA3..0x00000BA4, 0x00000BA8..0x00000BAA, 0x00000BAE..0x00000BB5, 0x00000BB7..0x00000BB9, 0x00000C05..0x00000C0C, 0x00000C0E..0x00000C10, 0x00000C12..0x00000C28, 0x00000C2A..0x00000C33, 0x00000C35..0x00000C39, 0x00000C60..0x00000C61, 0x00000C85..0x00000C8C, 0x00000C8E..0x00000C90, 0x00000C92..0x00000CA8, 0x00000CAA..0x00000CB3, 0x00000CB5..0x00000CB9, 0x00000CDE, 0x00000CE0..0x00000CE1, 0x00000D05..0x00000D0C, 0x00000D0E..0x00000D10, 0x00000D12..0x00000D28, 0x00000D2A..0x00000D39, 0x00000D60..0x00000D61, 0x00000E01..0x00000E2E, 0x00000E30, 0x00000E32..0x00000E33, 0x00000E40..0x00000E45, 0x00000E81..0x00000E82, 0x00000E84, 0x00000E87..0x00000E88, 0x00000E8A, 0x00000E8D, 0x00000E94..0x00000E97, 0x00000E99..0x00000E9F, 0x00000EA1..0x00000EA3, 0x00000EA5, 0x00000EA7, 0x00000EAA..0x00000EAB, 0x00000EAD..0x00000EAE, 0x00000EB0, 0x00000EB2..0x00000EB3, 0x00000EBD, 0x00000EC0..0x00000EC4, 0x00000F40..0x00000F47, 0x00000F49..0x00000F69, 0x000010A0..0x000010C5, 0x000010D0..0x000010F6, 0x00001100, 0x00001102..0x00001103, 0x00001105..0x00001107, 0x00001109, 0x0000110B..0x0000110C, 0x0000110E..0x00001112, 0x0000113C, 0x0000113E, 0x00001140, 0x0000114C, 0x0000114E, 0x00001150, 0x00001154..0x00001155, 0x00001159, 0x0000115F..0x00001161, 0x00001163, 0x00001165, 0x00001167, 0x00001169, 0x0000116D..0x0000116E, 0x00001172..0x00001173, 0x00001175, 0x0000119E, 0x000011A8, 0x000011AB, 0x000011AE..0x000011AF, 0x000011B7..0x000011B8, 0x000011BA, 0x000011BC..0x000011C2, 0x000011EB, 0x000011F0, 0x000011F9, 0x00001E00..0x00001E9B, 0x00001EA0..0x00001EF9, 0x00001F00..0x00001F15, 0x00001F18..0x00001F1D, 0x00001F20..0x00001F45, 0x00001F48..0x00001F4D, 0x00001F50..0x00001F57, 0x00001F59, 0x00001F5B, 0x00001F5D, 0x00001F5F..0x00001F7D, 0x00001F80..0x00001FB4, 0x00001FB6..0x00001FBC, 0x00001FBE, 0x00001FC2..0x00001FC4, 0x00001FC6..0x00001FCC, 0x00001FD0..0x00001FD3, 0x00001FD6..0x00001FDB, 0x00001FE0..0x00001FEC, 0x00001FF2..0x00001FF4, 0x00001FF6..0x00001FFC, 0x00002126, 0x0000212A..0x0000212B, 0x0000212E, 0x00002180..0x00002182, 0x00003041..0x00003094, 0x000030A1..0x000030FA, 0x00003105..0x0000312C, 0x0000AC00..0x0000D7A3 then
            Result := True
         else
            check not Result end
         end
      end

   is_ideographic (unicode: INTEGER): BOOLEAN
      do
         inspect
            unicode
         when 0x00004E00..0x00009FA5, 0x00003007, 0x00003021..0x00003029 then
            Result := True
         else
            check not Result end
         end
      end

   is_combining_char (unicode: INTEGER): BOOLEAN
      do
         inspect
            unicode
         when 0x00000300..0x00000345, 0x00000360..0x00000361, 0x00000483..0x00000486, 0x00000591..0x000005A1, 0x000005A3..0x000005B9, 0x000005BB..0x000005BD, 0x000005BF, 0x000005C1..0x000005C2, 0x000005C4, 0x0000064B..0x00000652, 0x00000670, 0x000006D6..0x000006DC, 0x000006DD..0x000006DF, 0x000006E0..0x000006E4, 0x000006E7..0x000006E8, 0x000006EA..0x000006ED, 0x00000901..0x00000903, 0x0000093C, 0x0000093E..0x0000094C, 0x0000094D, 0x00000951..0x00000954, 0x00000962..0x00000963, 0x00000981..0x00000983, 0x000009BC, 0x000009BE, 0x000009BF, 0x000009C0..0x000009C4, 0x000009C7..0x000009C8, 0x000009CB..0x000009CD, 0x000009D7, 0x000009E2..0x000009E3, 0x00000A02, 0x00000A3C, 0x00000A3E, 0x00000A3F, 0x00000A40..0x00000A42, 0x00000A47..0x00000A48, 0x00000A4B..0x00000A4D, 0x00000A70..0x00000A71, 0x00000A81..0x00000A83, 0x00000ABC, 0x00000ABE..0x00000AC5, 0x00000AC7..0x00000AC9, 0x00000ACB..0x00000ACD, 0x00000B01..0x00000B03, 0x00000B3C, 0x00000B3E..0x00000B43, 0x00000B47..0x00000B48, 0x00000B4B..0x00000B4D, 0x00000B56..0x00000B57, 0x00000B82..0x00000B83, 0x00000BBE..0x00000BC2, 0x00000BC6..0x00000BC8, 0x00000BCA..0x00000BCD, 0x00000BD7, 0x00000C01..0x00000C03, 0x00000C3E..0x00000C44, 0x00000C46..0x00000C48, 0x00000C4A..0x00000C4D, 0x00000C55..0x00000C56, 0x00000C82..0x00000C83, 0x00000CBE..0x00000CC4, 0x00000CC6..0x00000CC8, 0x00000CCA..0x00000CCD, 0x00000CD5..0x00000CD6, 0x00000D02..0x00000D03, 0x00000D3E..0x00000D43, 0x00000D46..0x00000D48, 0x00000D4A..0x00000D4D, 0x00000D57, 0x00000E31, 0x00000E34..0x00000E3A, 0x00000E47..0x00000E4E, 0x00000EB1, 0x00000EB4..0x00000EB9, 0x00000EBB..0x00000EBC, 0x00000EC8..0x00000ECD, 0x00000F18..0x00000F19, 0x00000F35, 0x00000F37, 0x00000F39, 0x00000F3E, 0x00000F3F, 0x00000F71..0x00000F84, 0x00000F86..0x00000F8B, 0x00000F90..0x00000F95, 0x00000F97, 0x00000F99..0x00000FAD, 0x00000FB1..0x00000FB7, 0x00000FB9, 0x000020D0..0x000020DC, 0x000020E1, 0x0000302A..0x0000302F, 0x00003099, 0x0000309A then
            Result := True
         else
            check not Result end
         end
      end

   is_extender (unicode: INTEGER): BOOLEAN
      do
         inspect
            unicode
         when 0x000000B7, 0x000002D0, 0x000002D1, 0x00000387, 0x00000640, 0x00000E46, 0x00000EC6, 0x00003005, 0x00003031..0x00003035, 0x0000309D..0x0000309E, 0x000030FC..0x000030FE then
            Result := True
         else
            check not Result end
         end
      end

   is_letter (unicode: INTEGER): BOOLEAN
      do
         Result := is_base_char(unicode) or else is_ideographic(unicode)
      end

   is_digit (unicode: INTEGER): BOOLEAN
      do
         inspect
            unicode
         when 0x00000030..0x00000039, 0x00000660..0x00000669, 0x000006F0..0x000006F9, 0x00000966..0x0000096F, 0x000009E6..0x000009EF, 0x00000A66..0x00000A6F, 0x00000AE6..0x00000AEF, 0x00000B66..0x00000B6F, 0x00000BE7..0x00000BEF, 0x00000C66..0x00000C6F, 0x00000CE6..0x00000CEF, 0x00000D66..0x00000D6F, 0x00000E50..0x00000E59, 0x00000ED0..0x00000ED9, 0x00000F20..0x00000F29 then
            Result := True
         else
            check not Result end
         end
      end

end -- class UNICODE_CHARACTERS
--
-- Copyright (C) 2009-2017: by all the people cited in the AUTHORS file.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
