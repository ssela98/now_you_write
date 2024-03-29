# frozen_string_literal: true

# == Schema Information
#
# Table name: stories
#
#  id                             :integer          not null, primary key
#  user_id                        :integer          not null
#  title                          :string           not null
#  visible                        :boolean          default(TRUE)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  cached_scoped_like_votes_total :integer          default(0)
#  cached_scoped_like_votes_score :integer          default(0)
#  cached_scoped_like_votes_up    :integer          default(0)
#  cached_scoped_like_votes_down  :integer          default(0)
#  cached_weighted_like_score     :integer          default(0)
#  cached_weighted_like_total     :integer          default(0)
#  cached_weighted_like_average   :float            default(0.0)
#
class Story < ApplicationRecord
  include Votable

  belongs_to :user

  has_many :comments, dependent: :destroy, inverse_of: :story
  has_many :pins, dependent: :destroy, inverse_of: :story
  has_many :story_tags, dependent: :destroy, inverse_of: :story
  has_many :tags, through: :story_tags

  # TODO: extract this and comment.rb's part in a concern
  has_rich_text :content
  scope :joins_content, lambda {
                          joins("INNER JOIN action_text_rich_texts
                                        ON action_text_rich_texts.record_id = stories.id
                                        AND action_text_rich_texts.record_type = 'Story'")
                        }
  scope :where_content, lambda { |content|
    return joins_content.where(action_text_rich_texts: { body: nil }) unless content

    joins_content.where('action_text_rich_texts.body LIKE ?', "%#{content}%")
  }

  validates :title, presence: true
  validates :content, no_attachments: true

  scope :filter_by_date, ->(date) { where('created_at >= ?', date) if date }
  scope :filter_by_date_keyword, lambda { |keyword|
    case keyword
    when 'today'
      filter_by_date(Time.zone.today.at_beginning_of_day)
    when 'this_week'
      filter_by_date(Time.zone.today.at_beginning_of_week)
    when 'this_month'
      filter_by_date(Time.zone.today.at_beginning_of_month)
    when 'this_year'
      filter_by_date(Time.zone.today.at_beginning_of_year)
    end
  }
end
