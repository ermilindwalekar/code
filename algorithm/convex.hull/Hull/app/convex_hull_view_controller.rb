class ConvexHullViewController < UIViewController
=begin rdoc
  # 아래처럼 썼다면 self.view 자체가 canvas view가 되는 것
  # viewDidLoad 이하에 코드를 삽입하는 것은 기본 self.view의 자식에 다른 view
  # 를 삽입하는 것
  def loadView
    self.view = CanvasView.alloc.init
  end
=end

  def viewDidLoad
    super
    #@queue = Dispatch::Queue.new("com.myhome.hull.task")

    self.title = "Jarvis March"

    vs = view.bounds.size
    ns = navigationController.navigationBar.frame.size
    ts = navigationController.toolbar.frame.size
    frame = [[0, 0], [vs.width, vs.height]]
    @canvas_view = CanvasView.alloc.initWithFrame(frame)
    @canvas_view.selected_mode = 0

    self.view.addSubview(@canvas_view)
  end

  def viewWillAppear(animated)
    super(animated)

    navigationController.setNavigationBarHidden(false, animated:true)
    navigationController.setToolbarHidden(false, animated:true)

    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleDefault
    
    nb = self.navigationController.navigationBar 
    nb.barStyle    = UIBarStyleDefault
    nb.translucent = true; nb.alpha = 0.8

    tb = self.navigationController.toolbar
    tb.barStyle    = UIBarStyleDefault
    tb.translucent = true; tb.alpha = 0.8

    b1 = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
            UIBarButtonSystemItemRefresh,
            target:self,
            action:'clearCanvas')

    b2 = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
            UIBarButtonSystemItemPlay,
            target:self,
            action:'findHull')

    @sg = UISegmentedControl.alloc.initWithItems(["1", "3R", "5R"])
    @sg.selectedSegmentIndex = 0
    @sg.frame = [[0, 0], [100, 30]]
    @sg.addTarget(self, action:'segmentDidChange:', forControlEvents:UIControlEventValueChanged)
    bs = UIBarButtonItem.alloc.initWithCustomView(@sg)

    self.setToolbarItems([b1, b2, bs], animated:true);

    UIView.setAnimationsEnabled(true)
  end

  def clearCanvas
    @canvas_view.clearCanvas
    # @queue.async { sleep 1; puts :hello }
  end

  def findHull
    @canvas_view.findHull
  end

  def segmentDidChange(sender)
    @canvas_view.selected_mode = sender.selectedSegmentIndex
  end
end
