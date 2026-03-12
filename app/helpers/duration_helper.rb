module DurationHelper
  def duration_options
    [
    [ "15分", 15 ],
    [ "30分", 30 ],
    [ "45分", 45 ],
    [ "1時間", 60 ],
    [ "1時間30分", 90 ],
    [ "2時間", 120 ],
    [ "3時間", 180 ],
    [ "半日", 240 ],
    [ "1日", 480 ]
    ]
  end

  def duration_label(minutes)
    duration_options.find { |label, value| value == minutes }&.first
  end
end
