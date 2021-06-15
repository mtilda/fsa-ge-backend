json.extract! program
json.id program.id
json.credential_level [
  'Undergraduate certificate (includes diploma)',
  'Associate’s degree',
  'Bachelor’s degree',
  'Post baccalaureate certificate',
  'Master’s degree',
  'Doctoral degree',
  'First professional degree, at the graduate level (e.g., M.D., D.D.S, J.D.)',
  'Graduate certificate'
][program.credential_level - 1]
