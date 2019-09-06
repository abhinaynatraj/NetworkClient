//
//  MoviesViewController.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel: MoviesViewModelType = MoviesViewModel()
    private var observationDisposeBag: [ObservationDispose] = []
    private var defaultSectionHeaderFooterHeight: CGFloat {
        /// This is a fix for iOS 10 crashing when header/footer is set to leastNormalMagnitude
        if #available(iOS 11.0, *) {
            return CGFloat.leastNormalMagnitude
        }
        return 1.01
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
        setupTableView()
        viewModel.inputs.viewReady()
    }

    // MARK: Observables

    private func setupObservables() {
        observationDisposeBag = [
            viewModel.outputs.reloadTable.subscribe({ [weak self] change in
                DispatchQueue.main.async {
                    self?.tableView.reload(change: change)

                    if UIAccessibility.isVoiceOverRunning {
                        if case .all = change {
                            UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: nil)
                        }
                    }
                }
            })
        ]
    }

    private func setupTableView() {
        view.bringSubviewToFront(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        //tableView.backgroundColor = .lightGray
        tableView.separatorStyle = .none
        let moviesListCellName = String(describing: MoviesListCell.self)
        let nib = UINib.init(nibName: moviesListCellName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: moviesListCellName)
    }
}

extension MoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.outputs.sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.outputs.sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.reuseIdentifier, for: indexPath)
        if let cellView = cell as? CellView {
            cellView.configure(cellModel: cellModel, indexPath: indexPath)
        }
        cell.accessibilityIdentifier = cellModel.identifier
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.didSelectItem(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.outputs.sections[section].footer?.height ?? defaultSectionHeaderFooterHeight
    }

//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        guard let footerModel = viewModel.outputs.sections[section].footer else {
//            return nil
//        }
//
//        let reuseIdentifier = footerModel.reuseIdentifier
//        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
//        if let footerView = view as? InvestingHeaderFooter {
//            footerView.configure(headerFooterModel: footerModel, section: section)
//        }
//        return view
//    }
//
//    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return viewModel.outputs.sections[section].header?.height ?? defaultSectionHeaderFooterHeight
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerModel = viewModel.outputs.sections[section].header else {
//            return nil
//        }
//        let reuseIdentifier = headerModel.reuseIdentifier
//        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
//        if let headerView = view as? HeaderFooterView {
//            headerView.configure(headerFooterModel: headerModel, section: section)
//        }
//        return view
//    }
}
