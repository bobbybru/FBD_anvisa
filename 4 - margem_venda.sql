SELECT 
round((100*(a.pmc-a.pf)/a.pf),2) as margem_venda,
a.Medicamento_produto
FROM anvisa.preco as a
group by a.Medicamento_principio_ativo
order by margem_venda desc