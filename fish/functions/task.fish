function task
  if count $argv > /dev/null
    command task $argv
  else
    command task ready -parked
  end
end
