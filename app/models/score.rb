class Score

  def initialize(local_primary:, local_general:, national_midterm:, national_presidential:, score_w_scaled:, score_total_scaled:, **kwargs)
    @local_primary = local_primary
    @local_general = local_general
    @national_midterm = national_midterm
    @national_presidential = national_presidential
    @score_w_scaled = score_w_scaled
    @score_total_scaled = score_total_scaled
  end

  def local_primary
    (Float(@local_primary) * 100).round(0)
  end

  def local_general
    (Float(@local_general) * 100).round(0)
  end
  def national_midterm
    (Float(@national_midterm) * 100).round(0)
  end
  def national_presidential
    (Float(@national_presidential) * 100).round(0)
  end
  def score_w_scaled
    (Float(@score_w_scaled) * 100).round(0)
  end
  def score_total_scaled
    (Float(@score_total_scaled) * 100).round(0)
  end
end
