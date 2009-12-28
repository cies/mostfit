class Payments < Application
  before :get_context, :exclude => ['redirect_to_show']
  provides :xml, :yaml, :js

  def index
    @payments = @loan.payments
    display @payments
  end

#   def show(id)
#     @payment = Payment.get(id)
#     raise NotFound unless @payment
#     display @payment
#   end

  def new
    only_provides :html
    @payment = Payment.new
    display @payment
  end

  def create(payment)
    debugger
    raise NotFound unless @loan
      
    amounts = payment[:amount].to_i
    receiving_staff = StaffMember.get(payment[:received_by])
    if payment[:type] == "total"
    # we create payment through the loan, so subclasses of the loan can take full responsibility for it (validations and such)
      succes, @prin, @int, @fees = @loan.repay(amounts, session.user, parse_date(payment[:received_on]), receiving_staff, params[:style])
      @payment = Payment.new
      @prin.errors.to_hash.each{|k,v| @payment.errors.add(k,v)}  if @prin
      @int.errors.to_hash.each{|k,v| @payment.errors.add(k,v)}  if @int
      @fees.errors.to_hash.each{|k,v| @payment.errors.add(k,v)}  if @fees
    else
      @payment = Payment.new(payment)
      succes = Payment.save
    end
    
    if succes  # true if saved
      redirect url_for_loan(@loan), :message => {:notice => "Payment ##{@payment.id} has been registered"}
    else
      render :new
    end
  end

#   def edit(id)
#     only_provides :html
#     @payment = Payment.get(id)
#     raise NotFound unless @payment
#     display @payment
#   end
# 
#   def update(id, payment)
#     @payment = Payment.get(id)
#     raise NotFound unless @payment
#     if @payment.update_attributes(payment)
#        redirect resource(@payment)
#     else
#       display @payment, :edit
#     end
#   end

  def delete(id)
    only_provides :html
    @payment = Payment.get(id)
    raise NotFound unless @payment
    redirect url_for_loan(@loan, 'payments'), :message => {:notice => "Payment '#{@payment.id}' has been deleted"}
  end

  def destroy(id)
    @payment = Payment.get(id)
    raise NotFound unless @payment
    if @loan.delete_payment(@payment, session.user)
      redirect url_for_loan(@loan, 'payments'), :message => {:notice => "Payment '#{@payment.id}' has been deleted"}
    else
      redirect url_for_loan(@loan, 'payments'), :message => {:error => "Could not delete payment '#{@payment.id}'"}
    end
  end


  private
  include DateParser

  def get_context
    @branch = Branch.get(params[:branch_id])
    @center = Center.get(params[:center_id])
    @client = Client.get(params[:client_id])
    @loan   = Loan.get(params[:loan_id])
    raise NotFound unless @branch and @center and @client and @loan
  end
end # Payments
