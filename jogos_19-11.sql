insert into partidas (campeonato_id, numero, data, a1, a2, b1, b2, placar_a, placar_b)
select 'nov-qui', v.numero, date '2026-11-19', v.a1, v.a2, v.b1, v.b2, v.pa, v.pb
from (values
  (19, 'Hercílio', 'Felipe', 'Norton', 'Geraldo', 4, 2),
  (20, 'Hercílio', 'Alexandre', 'Norton', 'Hemerson', 2, 4),
  (21, 'Felipe', 'Alexandre', 'Hercílio', 'Geraldo', 0, 4),
  (22, 'Geraldo', 'Hemerson', 'Hercílio', 'Norton', 1, 4),
  (23, 'Hercílio', 'Hemerson', 'Alexandre', 'Geraldo', 3, 4),
  (24, 'Felipe', 'Geraldo', 'Alexandre', 'Hemerson', 4, 1),
  (25, 'Felipe', 'Hemerson', 'Norton', 'Alexandre', 4, 0),
  (26, 'Norton', 'Felipe', 'Hercílio', 'Geraldo', 3, 4),
  (27, 'Norton', 'Hemerson', 'Felipe', 'Alexandre', 4, 1)
) as v(numero, a1, a2, b1, b2, pa, pb)
where not exists (select 1 from partidas p where p.campeonato_id = 'nov-qui' and p.numero = v.numero);
