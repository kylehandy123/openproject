#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2021 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

# Sends mails for announcements.
# For now, it cannot handle sending events on any Announcement model but is rather focused
# on handing very simple mails where only the recipient, subject and body is provided.

class AnnouncementMailer < ApplicationMailer
  include OpenProject::StaticRouting::UrlHelpers
  include OpenProject::TextFormatting
  helper :mail_notification

  def announce(user, subject:, body:, body_header: nil, body_subheader: nil)
    with_locale_for(user) do
      mail to: user.mail,
           subject: subject do |format|
        locals = {
          body: body,
          user: user,
          header_summary: subject,
          body_header: body_header,
          body_subheader: body_subheader
        }

        format.html { render locals: locals }
        format.text { render locals: locals }
      end
    end
  end
end
