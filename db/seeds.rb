Games::GenerateService.call(params: { cell_type: Game::SQUARE, map_size: { q: 20, r: 20 } })

Users::CreateService.call(
  params: {
    email: 'first@gmail.com',
    password: '1234qwerQWER',
    password_confirmation: '1234qwerQWER'
  },
  with_send_confirmation: false
)
