-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class READLINE_JOB

inherit
   UI_JOB
      redefine
         application
      end

create {USER_INTERFACE}
   connect

feature {LOOP_ITEM}
   prepare (events: EVENTS_SET) is
      local
         t: TIME_EVENTS
      do
         stream.set_prompt(once "> ")
         events.expect(t.timeout(0)) -- because readline cannot be select(2)'ed
      end

   is_ready (events: EVENTS_SET): BOOLEAN is
      do
         Result := True
      end

   continue is
      do
         application.run(stream)
      end

   done: BOOLEAN is
      do
         Result := stream = Void or else not stream.is_connected
      end

   restart is
      do
         create stream.make
      end

feature {UI_ITEM}
   new_bridge_application (ui: UI_APPLICATION): READLINE_APPLICATION is
      do
         create Result.make(ui)
      end

   new_bridge_window (ui: UI_WINDOW): READLINE_WINDOW is
      do
         create Result.make(ui)
      end

   new_bridge_panel (ui: UI_PANEL): READLINE_PANEL is
      do
         create Result.make(ui)
      end

   new_bridge_menu (ui: UI_MENU): READLINE_MENU is
      do
         create Result.make(ui)
      end

   new_bridge_text_field (ui: UI_TEXT_FIELD): READLINE_TEXT_FIELD is
      do
         create Result.make(ui)
      end

   new_bridge_button (ui: UI_BUTTON): READLINE_BUTTON is
      do
         create Result.make(ui)
      end

feature {}
   application: READLINE_APPLICATION
   stream: READLINE_INPUT_STREAM

end -- class READLINE_JOB
--
-- Copyright (c) 2012 Cyril ADRIAN <cyril.adrian@gmail.com>.
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