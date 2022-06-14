import 'package:attendance/core.dart';

List<TableUser> listCommonUser = <TableUser>[
  TableUser(
    id: 1,
    username: 'user1',
    password: encrypt('password1'),
  ),
  TableUser(
    id: 2,
    username: 'user2',
    password: encrypt('password2'),
  ),
  TableUser(
    id: 3,
    username: 'user3',
    password: encrypt('password3'),
  ),
];

List<TableLocation> commonLocation = <TableLocation>[
  TableLocation(
    id: 1,
    desc: 'Office Dummy',
    latitude: -6.226477644164325,
    longtitude: 106.83326146918816,
    isActive: true,
  ),
];
