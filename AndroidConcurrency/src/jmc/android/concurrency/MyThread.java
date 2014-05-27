package jmc.android.concurrency;

public class MyThread extends Thread {

	public MyThread() {
		// TODO Auto-generated constructor stub
	}

	public MyThread(Runnable runnable) {
		super(runnable);
		// TODO Auto-generated constructor stub
	}

	public MyThread(String threadName) {
		super(threadName);
		// TODO Auto-generated constructor stub
	}

	public MyThread(Runnable runnable, String threadName) {
		super(runnable, threadName);
		// TODO Auto-generated constructor stub
	}

	public MyThread(ThreadGroup group, Runnable runnable) {
		super(group, runnable);
		// TODO Auto-generated constructor stub
	}

	public MyThread(ThreadGroup group, String threadName) {
		super(group, threadName);
		// TODO Auto-generated constructor stub
	}

	public MyThread(ThreadGroup group, Runnable runnable, String threadName) {
		super(group, runnable, threadName);
		// TODO Auto-generated constructor stub
	}

	public MyThread(ThreadGroup group, Runnable runnable, String threadName,
			long stackSize) {
		super(group, runnable, threadName, stackSize);
		// TODO Auto-generated constructor stub
	}

}
