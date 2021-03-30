SELECT x.*
FROM
(SELECT count(CD_GGEREM) as total_registro,
		b.tarja,
        d.nome
FROM anvisa.registro as a
right JOIN anvisa.medicamento as b
ON a.CD_GGEREM=b.Registro_CD_GGEREM
INNER JOIN anvisa.laboratorio_has_medicamento as c
ON b.produto=c.Medicamento_produto and b.apresentacao=c.Medicamento_apresentacao
    and b.principio_ativo=c.Medicamento_principio_ativo
right JOIN anvisa.laboratorio as d
ON c.Laboratorio_cnpj=d.cnpj
group by b.tarja,
		 d.nome
order by total_registro desc) as x
where x.total_registro>300

