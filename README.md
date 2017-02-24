# UITableView-FDTemplateLayoutCell.swift
It is translation of the [UITableView-FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell) by Swift

# Overview
![](https://github.com/huangboju/UITableView-FDTemplateLayoutCell.swift/blob/master/2017-02-24%2014_47_18.gif)

#Usage
* No cache
```swift
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(with: "cell") { (cell) in
        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
        // Like:
        //    cell.data = datas[indexPath.row]
        }
  }
```

* IndexPath cache
```swift
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(with: "cell", cacheBy: indexPath) { (cell) in
        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
        // Like:
        //    cell.data = datas[indexPath.row]
        }
  }
```

* Key cache
```swift
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(with: "cell", cacheByKey: entity.identifier ?? "") { (cell) in
        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
        // Like:
        //    cell.data = datas[indexPath.row]
        }
  }
```

# Frame layout mode

`FDTemplateLayoutCell.swift` offers 2 modes for asking cell's height.

* Auto layout mode using "-systemLayoutSizeFittingSize:"
* Frame layout mode using "-sizeThatFits:"

**You can use this API change mode for asking cell's height,default is true, because use "frame layout" rather than "auto layout".**
```swift
cell.fd_usingFrameLayout = false
```
