
service_name="Factory"
default_port=7419

wait_for_running() {
  container=$1
  until docker exec ${container} bash -c "ps aux | grep [f]aktory"
  do
    sleep 1
  done
}

wait_for_listening() {
  container=$1
  ip=$2
  port=$3
  until docker exec ${container} bash -c "nc -q 1 ${ip} ${port} < /dev/null"
  do
    sleep 1
  done
}

wait_for_stop() {
  container=$1
  while docker exec ${container} bash -c "ps aux | grep [f]aktory"
  do
    sleep 1
  done
}

verify_stopped() {
  container=$1
  run docker exec ${container} bash -c "ps aux | grep [f]aktory"
  echo_lines
  [ "$status" -eq 1 ] 
}

insert_test_data() {
  container=$1
  ip=$2
  port=$3
  key=$4
  data=$5
  # run docker exec ${container} bash -c "some command"
  # [ "$status" -eq 0 ]
}

update_test_data() {
  container=$1
  ip=$2
  port=$3
  key=$4
  data=$5
  # run docker exec ${container} bash -c "some command"
  # [ "$status" -eq 0 ]
}

verify_test_data() {
  container=$1
  ip=$2
  port=$3
  key=$4
  data=$5
  # run docker exec ${container} bash -c "some command"
  # echo_lines
  # [ "${lines[0]}" = "${data}" ]
  # [ "$status" -eq 0 ]
}

verify_plan() {
  [ "${lines[0]}" = "{" ]
  [ "${lines[1]}" = "  \"redundant\": false," ]
  [ "${lines[2]}" = "  \"horizontal\": false," ]
  [ "${lines[3]}" = "  \"user\": \"nanobox\"," ]
  [ "${lines[4]}" = "  \"users\": [" ]
  [ "${lines[5]}" = "    {" ]
  [ "${lines[6]}" = "      \"username\": \"nanobox\"," ]
  [ "${lines[7]}" = "      \"meta\": {" ]
  [ "${lines[8]}" = "      }" ]
  [ "${lines[9]}" = "    }" ]
  [ "${lines[10]}" = "  ]," ]
  [ "${lines[11]}" = "  \"ips\": [" ]
  [ "${lines[12]}" = "    \"default\"" ]
  [ "${lines[13]}" = "  ]," ]
  [ "${lines[14]}" = "  \"port\": 7419," ]
  [ "${lines[15]}" = "  \"behaviors\": [" ]
  [ "${lines[16]}" = "    \"migratable\"" ]
  [ "${lines[17]}" = "  ]" ]
  [ "${lines[18]}" = "}" ]
}