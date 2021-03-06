package com.revature.americaonwine.data;

import java.util.List;

import com.revature.americaonwine.beans.InventoryItem;
import com.revature.americaonwine.beans.Transaction;
import com.revature.americaonwine.beans.User;

public interface TransactionDao {
	public int nextOrderNum();
	public Transaction addTransaction(Transaction tran);
	public List<Transaction> getForUser(User u);
	public Transaction updateTransaction(Transaction t);
	public List<Transaction> getTransByInv(InventoryItem inv);
}
