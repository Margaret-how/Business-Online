use ShopSystem
--insert_cust	�����µĿͻ���Ϣ	���ͻ��ɹ�ע����Զ��ڿͻ�����
--��Ӹÿͻ���ע����Ϣ
use ShopSystem
go
create procedure insert_cust
(@cust_id varchar(20),@cust_pwd char(32),@email varchar(30))
as
declare @num int
select @num=count(cust_id) from customer where cust_id=@cust_id
if @num=0
	insert into customer(cust_id,cust_pwd,email) values(@cust_id,@cust_pwd,@email)
else 
	print'��ID��ע��'
go
--����洢���̵���֤
--select * from customer
--insert into customer(cust_id,cust_pwd,email) values('U10000','123456','test@shop.com')
--exec insert_cust 'U110000','123456','test@shop.com'

--select_cust	��ѯ�ͻ�������Ϣ	��¼ϵͳ�󣬿ͻ����Բ�ѯ������Ϣ
go
create procedure select_cust @cust_id varchar(20)
as
select * from customer where @cust_id=cust_id
go
--��֤
select * from customer 
exec select_cust 'U10000'

--update_cust	�޸Ŀͻ�������Ϣ	��¼ϵͳ�󣬿ͻ������޸ĸ�����Ϣ
drop procedure update_cust
go
create procedure update_cust 
(
@cust_id varchar(20),
@cust_pwd char(32),
@cust_name varchar(16) ,
@addr varchar(60),
@email varchar(30),
@zip char(6),
@tel char(11),
@sex char(2) ,
@cust_sco int
)
as
update customer 
set cust_id=@cust_id,
cust_pwd=@cust_pwd,
cust_name=@cust_name,
email=@email,
addr=@addr,
tel=@tel,
zip=@zip,
sex=@sex,
cust_sco=@cust_sco
 where (cust_id=@cust_id)
go
select * from customer
exec update_cust 'U10000','12345','TTest','�������ϰ���','TTest@shop.cn','101010','��','18723937311','0'

--chan_level	�޸Ŀͻ��ȼ�	���ͻ����ִﵽһ��Ҫ���Զ��޸Ŀͻ��ȼ�
drop trigger cust_level
go
create trigger cust_level
on customer
for insert,update
as 
update customer set cust_level=1 where (0<=cust_sco and cust_sco <500)
update customer set cust_level=2 where (500<=cust_sco and cust_sco <1000)
update customer set cust_level=3 where (1000<=cust_sco )
go

update customer set cust_sco=1000 where cust_id='U10000'
select * from customer
--add_score	���ӿͻ�����	���ɶ���������ݶ�������Զ����ӻ���
--code_detect	���ͻ���ע�������Ƿ����Ҫ��	���ͻ���������ʱ���Զ���������Ƿ���6-12λ֮�䣬������ʾ����������
--select_sales	��ѯ����	���ͻ���ѯʱ��ֻ�ܲ�ѯ����˶�����Ϣ 
--insert_product	����µ���Ʒ��Ϣ	�ڴ洢��������insert�������µ���Ʒ��Ϣ
--insert_kind	����µ���Ʒ�����Ϣ	����µ���Ʒ��Ϣʱ�����������µ������Ӧ������������Ӹ���Ʒ���
--insert_sup	����µ�����������Ϣ	����µ���Ʒ��Ϣʱ������Ϊ�µĳ�����������Ӧ�����������ұ�����Ӹ�����������
--delete_sup	ɾ����������	��delete����ɾ��ĳ���������ң���ʱ��ƷӦ������ɾ������
--delete_product	ɾ����Ʒ��Ϣ	����Ʒ��������ʱ��ɾ����Ʒ��Ϣ
--add_prod	��ʾ�����Ʒ��Ϣ	����Ʒ�����С��100ʱ����ʾҪ�����Ʒ
--chan_price	�޸���Ʒ�۸�	����Ʒ�ӽ������ڣ�����Ч���ڼ�ȥϵͳʱ������õ�ֵС��3���£��������Ʒ��Ϊ�ؼ���Ʒ��������Ʒ����޸���Ʒ�۸�
--kind_select	����Ʒ�������ѯ��Ʒ��Ϣ	�ͻ�����������Ʒ�������ѯ�Լ���Ҫ����Ʒ
--sup_select	��������������ѯ��Ʒ��Ϣ	�ͻ���������������������ѯ�Լ���Ҫ����Ʒ
--prod_name_select	����Ʒ���Ʋ�ѯ��Ʒ��Ϣ	�ͻ�����������Ʒ���Ʋ�ѯ�Լ���Ҫ����Ʒ
--add_shopcart	������Ʒ�ݴ���������ﳵ�з�����Ʒ��	�ͻ������������Ʒʱ���Զ�����һ����Ʒ�ݴ��
--delete_shopcart 	ɾ����Ʒ�ݴ������չ��ﳵ��	���ͻ��ύ�����嵥���Զ��ѹ��ﳵ�е���Ʒ��Ϣ���
--calculate_shop_amt	�����ݴ���е���Ʒ�ܶ�	������Ʒ�ݴ���е���Ʒ�������ۺ�ۼ���ͻ��������Ʒ�ܶ�
--update_buy	�����Ƿ�����Ʒ	ͨ��update�����ͻ�����ȷ���Լ��Ƿ��빺�����Ʒ
--update_qty	�޸Ĺ��ﳵ�е���Ʒ����	����Ʒ�ݴ���пͻ�����ͨ���Լ�update���������Լ����������������Ʒ
--delete_shop_prod	ɾ���ͻ����빺�����Ʒ	����Ʒ�ݴ���еġ��Ƿ����ֶ�Ϊ���񡱣���ɾ������Ʒ
--calculate_price	������Ʒ�ۺ��	���ݿͻ��ȼ�������Ʒ�ݴ��Ͷ�����ϸ��ĵ��ͻ��ύ�����嵥����Ʒ�ۺ��
--add_deli	������Ʒ���͵�	���ͻ��ύ�����嵥���Զ�����һ����Ʒ���͵�
--update_deli	�޸����͵��еĿͻ���Ϣ	�����͵��еĿͻ���Ϣ���ͻ��Լ������޸�
--insert_item	���ɶ�����ϸ��Ͷ����ܱ�	���ͻ�����󣬸�����Ʒ�ݴ���Զ�����һ�Ŷ�����ϸ��ͬʱ����һ�Ŷ����ܱ�
--calculate_tot	���㶩���ܱ��е�tot_amtֵ	���ݶ�����ϸ���е���Ʒ�����͵��ۼ��㶩���ܱ��е�tot_amtֵ
--status_tri	�޸Ķ���״̬	���̼ҷ������͵�ʱ������״̬�Զ��޸�Ϊ��1������ʾ�����ѷ���
--insert_return	�����˻���	Ϊ�ͻ������˻�ҵ��ʱ������һ���˻���
--update_tri	�޸Ķ���	���˻������ɺ�ͬʱ�޸���Ӧ�Ķ�����ϸ��Ͷ����ܱ�����������
--totamount	ͳ����ĳһ�����������ܶ�	���ݿͻ���ַͳ����ĳһ�����������ܶ�
--cal_cust	ͳ��ÿ���ͻ��궩���ܶ�	���ݶ����ܱ�ͳ��ÿ���ͻ��궩���ܶ�
--sum_tot	ͳ���̳����ж����ܶ�	ͳ�����ж����ܱ�Ķ������
--cust_tri	������dbo�û�ɾ���ͻ���Ϣ	��ɾ���ͻ���Ϣʱ,���Ϊ�ͻ�,��û��ɾ����Ȩ��,��Ϊ����Ա,�����ɾ��
--detect_qty	���ͻ��������Ʒ�����Ƿ񳬹������	���ͻ�������Ʒ����ʱ��������Ƿ񳬹�����������ǣ�����ʾ������������������������,����������!������������Ʒ���п����Ӧ����Ӧ�ļ���
--prod_date_detect	�����Ʒ��������	����µ���Ʒ��Ϣʱ����������������Ƿ���ϵͳ����֮ǰ��������ʾ���������ڲ����ܴ���ϵͳ���ڣ����������룡��
--deliv_date_detect	�����������	���ɶ���ʱ������䶩�������Ƿ�����������֮ǰ��������ʾ���������ڲ����ܴ����������ڣ����������룡��
--update_sale_item	���¶����ܱ�	���޸Ķ�����ϸ��������򵥼�ʱ�������ܱ��tot_amtֵӦ����Ӧ���޸�

